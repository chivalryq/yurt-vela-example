import (
	"strconv"
)

"replica-webservice": {
	alias: ""
	annotations: {}
	attributes: {
		status: {}
		workload: {
			definition: {
				apiVersion: "apps/v1"
				kind:       "Deployment"
			}
			type: "deployments.apps"
		}
	}
	description: "Webservice, but can be replicated"
	labels: {}
	type: "component"
}

template: {
	output: {
		apiVersion: "apps/v1"
		kind:       "Deployment"
		metadata: {
			if context.replicaKey != _|_ {
				name: context.name + "-" + context.replicaKey
			}
			if context.replicaKey == _|_ {
				name: context.name
			}
		}
		spec: {
			selector: matchLabels: {
				"app.oam.dev/component": context.name
				if context.replicaKey != _|_ {
					"app.oam.dev/replicaKey": context.replicaKey
				}
			}

			template: {
				metadata: {
					labels: {
						if parameter.labels != _|_ {
							parameter.labels
						}
						"app.oam.dev/name":      context.appName
						"app.oam.dev/component": context.name
						if context.replicaKey != _|_ {
							"app.oam.dev/replicaKey": context.replicaKey
						}
					}
				}

				spec: {
					containers: [{
						name:  context.name
						image: parameter.image
						if parameter["ports"] != _|_ {
							ports: [ for v in parameter.ports {
								{
									containerPort: v.port
									name:          "port-" + strconv.FormatInt(v.port, 10)
								}}]
						}
					}]
				}
			}
		}
	}
	exposePorts: [
		for v in parameter.ports {
			port:       v.port
			targetPort: v.port
			name:       "port-" + strconv.FormatInt(v.port, 10)
		},
	]
	outputs: {
		if len(exposePorts) != 0 {
			webserviceExpose: {
				apiVersion: "v1"
				kind:       "Service"
				metadata: {
					if context.replicaKey != _|_ {
						name: context.name + "-" + context.replicaKey
					}
					if context.replicaKey == _|_ {
						name: context.name
					}
				}
				spec: {
					selector: {
						"app.oam.dev/component": context.name
						if context.replicaKey != _|_ {
							"app.oam.dev/replicaKey": context.replicaKey
						}
					}
					ports: exposePorts
				}
			}
		}
	}
	parameter: {
		// +usage=Which image would you like to use for your service
		// +short=i
		image: string
		// +usage=Which ports do you want customer traffic sent to, defaults to 80
		ports?: [...{
			// +usage=Number of port to expose on the pod's IP address
			port: int
		}]
	}
}

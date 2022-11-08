"edge-nginx-ingress": {
	type: "trait"
	annotations: {}
	attributes: {
		podDisruptive: true
		appliesToWorkloads: ["helm"]
	}
}

template: {
	patch: {
		// +patchStrategy=retainKeys
		metadata: {
			name: "\(context.name)-\(context.replicaKey)"
		}
		// +patchStrategy=jsonMergePatch
		spec: values: {
			ingressClassByName: true
			controller: {
				ingressClassResource: {
					name:            "nginx-" + context.replicaKey
					controllerValue: "openyurt.io/" + context.replicaKey
				}
				_selector
			}
			defaultBackend: {
				_selector
			}
		}
	}
	_selector: {
		tolerations: [
			{
				key:      "apps.openyurt.io/example"
				operator: "Equal"
				value:    context.replicaKey
			},
		]
		nodeSelector: {
			"apps.openyurt.io/nodepool": context.replicaKey
		}
	}
	parameter: null
}

"edge-nginx-gateway-nginx": {
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
			_selector
			fullnameOverride: "nginx-gateway-nginx-" + context.replicaKey
			gatewayClass: {
				name:           "nginx" + context.replicaKey
				controllerName: "k8s-gateway-nginx.nginx.org/nginx-gateway-nginx-controller-" + context.replicaKey
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

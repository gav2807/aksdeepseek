param location string = 'uksouth'
param clusterName string
param dnsPrefix string
param nodeCount int = 2
param nodeVmSize string 
param kubernetesVersion string 
param servicePrincipalClientId string
@secure()
param servicePrincipalClientSecret string

resource aksCluster 'Microsoft.ContainerService/managedClusters@2023-05-01' = {
  name: clusterName
  location: location
  properties: {
    dnsPrefix: dnsPrefix
    kubernetesVersion: kubernetesVersion
    agentPoolProfiles: [{
      name: 'nodepool1'
      count: nodeCount
      vmSize: nodeVmSize
      mode: 'System'
    }]
    servicePrincipalProfile: {
      clientId: servicePrincipalClientId 
      secret:  servicePrincipalClientSecret 
    } 
  }
}

output kubeconfig string = aksCluster.properties.fqdn

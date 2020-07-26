# This state file deploys an ElasticSearch honeypot

# https://docs.saltstack.com/en/latest/ref/states/all/salt.states.docker_container.html#salt.states.docker_container.run


http_container:
  docker_container.running:
    - name: honeyswarm_elasticsearch_honeypot
    - image: honeyswarm/honeyswarm_elasticsearch_honeypot
    - environment:
      - HPFSERVER: {{salt['pillar.get']('HPFSERVER')}}
      - HPFPORT: {{salt['pillar.get']('HPFPORT')}}
      - HPFIDENT: {{salt['pillar.get']('HPFIDENT')}}
      - HPFSECRET: {{salt['pillar.get']('HPFSECRET')}}
      - HIVEID: {{salt['pillar.get']('HIVEID')}}
      - cluster.name: {{salt['pillar.get']('CLUSTER_NAME')}}
    - replace: true
    - force: true
    - port_bindings:
      - 9200:9200

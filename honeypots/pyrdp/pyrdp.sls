# Basic PyRDP Honeypot

# HPFeeds is in, but leaving the volume mount for now as it saves the recordings.

# Add the config file
create_dir:
  file.directory:
    - name: /etc/pyrdp
    - dir_mode: 777
    - file_mode: 777

pyrdp_container:
  docker_container.running:
    - name: honeypot_pyrdp
    - image: honeyswarm/honeyswarm_pyrdp:latest
    - environment:
      - HPFSERVER: {{salt['pillar.get']('HPFSERVER')}}
      - HPFPORT: {{salt['pillar.get']('HPFPORT')}}
      - HPFIDENT: {{salt['pillar.get']('HPFIDENT')}}
      - HPFSECRET: {{salt['pillar.get']('HPFSECRET')}}
      - HIVEID: {{salt['pillar.get']('HIVEID')}}
    - replace: true
    - port_bindings:
      - 3389:3389
    - binds: /etc/pyrdp/:/home/pyrdp/pyrdp_output
    - command: pyrdp-mitm.py -s {{salt['pillar.get']('HIVEID')}} {{salt['pillar.get']('WINDOWSTARGET')}}

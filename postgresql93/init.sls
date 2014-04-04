base:
  pkgrepo.managed:
    - name: deb http://apt.postgresql.org/pub/repos/apt/ {{ grains['oscodename'] }}-pgdg main
    - key_url: https://www.postgresql.org/media/keys/ACCC4CF8.asc
    - require_in:
      - pkg: postgresql

postgresql:
  pkg:
    - installed
    - name: postgresql-9.3
  service:
    - running
    - reload: True
    - require:
      - pkg: postgresql

postgresql-server-dev-9.3:
  pkg:
    - installed

include:
  - python
  - postgresql93

venv:
  virtualenv.managed:
    - name: {{ pillar['venv_dir'] }}
    - system_site_packages: False
    - require:
      - pkg: python

# requirements:
#   pip.installed:
#     - bin_env: {{ pillar['venv_dir'] }}
#     - requirements: {{ pillar['requirements'] }}

djangodbuser:
  postgres_user.present:
    - name: {{ pillar['dbuser'] }}
    - password: {{ pillar['dbpassword'] }}
    - require:
      - service: postgresql

djangodb:
  postgres_database.present:
    - name: {{ pillar['dbname'] }}
    - require:
        - postgres_user: djangodbuser

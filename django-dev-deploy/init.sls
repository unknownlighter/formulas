include:
  - python
  - postgresql93

venv:
  virtualenv.managed:
    - name: {{ pillar['venv_dir'] }}
    - system_site_packages: False
    - require:
      - pkg: python

requirements:
  pip.installed:
    - bin_env: {{ pillar['venv_dir'] }}
    - requirements: {{ pillar['requirements'] }}

djangodbuser:
  postgres_user.present:
    - name: {{ pillar['dbuser'] }}
    - password: {{ pillar['dbpassword'] }}
    - encrypted: False
    - require:
      - service: postgresql

djangodb:
  postgres_database.present:
    - name: {{ pillar['dbname'] }}
    - require:
        - postgres_user: djangodbuser

django.syncdb:
  module.run:
    - migrate: True
    - settings_module: {{ pillar['settings_module'] }}
    - bin_env: {{ pillar['venv_dir'] }}
    - pythonpath: {{ pillar['work_dir'] }}
 
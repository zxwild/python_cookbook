python_cookbook Cookbook
========================
AWS Python Environment (virtualenv, packages, etc)

Requirements
------------
Cookbooks from Berkshelf:

#### packages
- `python` - python_cookbook needs python from berkshelf

Attributes
----------
TODO: List you cookbook attributes here.

e.g.
#### python_cookbook::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['python_cookbook']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### python_cookbook::default

Custom JSON to configure (stack settings - Custom JSON):

```json
{
    "deploy": {
        "fshare": {
            "user": "user_x",
            "group": "group_x",
            "deploy_to": "/var/www/fshare",
            "directory_mode": "0755",
            "venv_path": "var/.env",
            "requirements": "requirements.txt",
            "pip_packages": [
                "Django==1.6.5",
                "Pillow==2.4.0",
                "South==0.8.4"
            ],
            "scm": {
                "scm_type": "git",
                "repository": "https://github.com/zxwild/fshare.git",
                "revision": "master",
                "user": "",
                "password": ""
            },
            "django_database": {
                "engine": "sqlite3",
                "name": "unique_sqlite_name.sqlite3",
                "user": "",
                "password": "",
                "host": "",
                "port": ""
            }
        }
    }
}
```

Contributing
------------


License and Authors
-------------------


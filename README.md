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
    "application_name": "app01",
    "user": "appuser",
    "group": "appuser",
    "setup": {
        "directory_mode": "0755",
        "base_path": "/var/www",
        "venv_path": "var/.env",
        "pip_packages": [
            "Django==1.6.5",
            "Pillow==2.4.0",
            "South==0.8.4"
        ]
    },
    "deploy": {
        "requirements_path": "requirements.txt"
    }
}
```

Contributing
------------


License and Authors
-------------------


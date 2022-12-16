# Code Generator
[Liste de tous les doc](../README.md)

<!-- TOC -->
* [Code Generator](#code-generator)
* [Generate Activity from scratch](#generate-activity-from-scratch)
* [Generate Bootstrap-React form using CSV](#generate-bootstrap-react-form-using-csv)
<!-- TOC -->

# Generate New Activity frontend

Lunch [CreateFrontActivity.sh](./CreateActivityFrontEnd.sh) to create new activity front end files following conventions.

Example: open terminal from root of the project and try following script:

```bash
./doc/code-generator/CreateActivityFrontEnd.sh MyModel
```

And try
```bash
./doc/code-generator/CreateActivityFrontEnd.sh PostDoc ./doc/code-generator/activities/PostDoc/PostDocForm.csv
```

After lunching script check [GeneratedCode folder](../../GeneratedCode)


# Generate Form Bootstrap & React using CSV

Lunch [CreateFrontActivity.sh](./CreateFormBootstrap.sh) to create a squelette form adapting with types of variable in csv.
For csv format check script file description, or take a look at [PostDocForm.csv](./activities/PostDoc/PostDocForm.csv)


Example: open terminal from root of the project and try following script:

```bash
./doc/code-generator/CreateFormBootstrap.sh ./doc/code-generator/activities/PostDoc/PostDocForm.csv
```

After lunching script check [GeneratedCode folder](../../GeneratedCode)
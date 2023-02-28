export class ActivityStatTemplate {

    constructor({idTypeActivity, label}) {
        this.idTypeActivity = idTypeActivity;
        this.label = label;
    }

    prepareData = (activityList) => activityList;
    filters = [];
    customGroupByList = [];

}
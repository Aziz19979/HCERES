#!/bin/bash
#################################################################################
#
# ModelEntity react generator
# This script will generate models based on a template model existing in the
# project.
#
# Usage: 1. change project dependent variable below for once (already done)
#        2. open bash terminal and navigate to project root location
#        3. Execute this script given ModelEntity as argument using CamelCase
#        (exemple PostDoc).
# if second argument specifying CSV data is given,
# then CreateFormBootstrap.sh is called too
# Example:  ./doc/code-generator/CreateFrontActivity.sh PostDoc
#################################################################################

# project dependent initialization
COMPONENTS="hceres-frontend/src/components/Activity"
SERVICES="hceres-frontend/src/services"
TemplateEntity="Education" ## Use CamelCase writing for template model


# initialize subfolder locations from content root
PROJECT_LOCATION=$(pwd)
SCRIPT_FOLDER_LOCATION=$(dirname "$0")
GENERATED_CODE_FOLDER="$PROJECT_LOCATION/GeneratedCode"
COMPONENTS_LOCATION="$PROJECT_LOCATION/$COMPONENTS"
SERVICES_LOCATION="$PROJECT_LOCATION/$SERVICES"


if [ $# == 0 ]; then
  >&2 echo "No ModelEntity name was provided"
  >&2 echo "Usage example:"
  >&2 echo "$0 ModelEntity"
  >&2 echo "Or"
  >&2 echo "$0 ModelEntity ModelForm.csv"
fi

ModelEntity=$1

check_if_folder_exist () {
  folderArg=$1
  # Check if component folder exist
  if [ -d "$folderArg" ]; then
      echo "$folderArg exists."
  else
    # print to standard error
    >&2 echo "$folderArg doesn't exist"
    >&2 echo "Execute this file from root project directory as working directory"
    exit 1
  fi
}

CamelCase_to_separate_by_dash() {
  # https://stackoverflow.com/questions/8502977/linux-bash-camel-case-string-to-separate-by-dash
  sed --expression 's/\([A-Z]\)/-\L\1/g' \
      --expression 's/^-//'              \
      <<< "$1"
}

template_package=$(CamelCase_to_separate_by_dash "$TemplateEntity")
templateComponent="$COMPONENTS_LOCATION/$template_package"
templateService="$SERVICES_LOCATION/$template_package"

# check component folder and template pacakge if exist
check_if_folder_exist "$COMPONENTS_LOCATION"
check_if_folder_exist "$templateComponent"
check_if_folder_exist "$SERVICES_LOCATION"
check_if_folder_exist "$templateService"

echo "$ModelEntity is used"

# initialize package name and targetLocations
target_package=$(CamelCase_to_separate_by_dash "$ModelEntity")
targetComponent="$GENERATED_CODE_FOLDER/$COMPONENTS/"
targetService="$GENERATED_CODE_FOLDER/$SERVICES/"

# clear Generated code folder
rm -r "$GENERATED_CODE_FOLDER"
echo "Code will be generated in: $GENERATED_CODE_FOLDER"

# Create target locations
mkdir -p "$targetComponent"
mkdir -p "$targetService"

echo "$targetComponent is created!"
echo "$targetService is created!"

# Copy templates files
cp -r "$templateComponent" "$targetComponent"
cp -r "$templateService" "$targetService"
echo "Templates are copied!"

# Rename pacakge as template pacakge
mv "$targetComponent/$template_package" "$targetComponent/$target_package"
mv "$targetService/$template_package" "$targetService/$target_package"
echo "Package $template_package renamed to $target_package"

# Traverse all files in Generated code recursively and perform following steps:
# For each file:
# 1. rename file TemplateEntity to ModelEntity
# 2. replace all occurrences of template_package name to target_package
# 3. replace all occurrences of TemplateEntity to ModelEntity
# 4. replace all occurrences of templateEntity to modelEntity
if [ -z ${allCreatedFixedFiles+x} ]; then declare -A allCreatedFixedFiles; fi

while IFS= read -r -d '' templateFile
do
  let count++
  echo "Found file no. $count"
  echo "$templateFile"
  if grep -q "$TemplateEntity" "$templateFile"; then
    # 1. rename file TemplateEntity to ModelEntity
    # ${variable//search/replace}
    modelFile=${templateFile//"$TemplateEntity"/"$ModelEntity"}
    mv "$templateFile" "$modelFile"
    echo "Renamed file to $modelFile"

    # 2. replace all occurrences of template_package name to target_package
    sed -i "s/\/$template_package/\/$target_package/g" "$modelFile"
    echo "Replaced /$template_package with /$target_package"

    # 3. replace all occurrences of TemplateEntity to ModelEntity
    sed -i "s/$TemplateEntity/$ModelEntity/g" "$modelFile"
    echo "Replaced $TemplateEntity with $ModelEntity"

    # 4. replace all occurrences of templateEntity to ModelEntity
    templateEntity="$(tr '[:upper:]' '[:lower:]' <<< ${TemplateEntity:0:1})${TemplateEntity:1}"
    modelEntity="$(tr '[:upper:]' '[:lower:]' <<< ${ModelEntity:0:1})${ModelEntity:1}"
    sed -i "s/$templateEntity/$modelEntity/g" "$modelFile"
    echo "Replaced $templateEntity with $modelEntity "
    allCreatedFixedFiles+=(["$count"]="$modelFile")
  fi
done <   <(find "$GENERATED_CODE_FOLDER" -mtime -7 -name '*.js' -print0)


if [ $# == 2 ]; then
  source "$SCRIPT_FOLDER_LOCATION/CreateFormBootstrap.sh" "$2"
fi

echo "${#allCreatedFixedFiles[@]} files are created in $GENERATED_CODE_FOLDER"
for i in ${allCreatedFixedFiles[*]}; do echo "$i"; done

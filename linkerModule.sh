#!/bin/bash

# Decelaration of all the variables
MODULE_NAME="$1"                                        #MODULE NAME
MODULE_NAME_CAP="$2"                                    #APP NAME
INIT_FILE=__init__.py                                   #__INIT__.PY FILE NAME
MODULE_MANIFEST_FILE=__manifest__.py                    #__MANIFEST__.PY FILE NAME


MANIFEST_OBJ="{\n\t'name': \"$MODULE_NAME_CAP\",\n\t'depends':[''],\n\t'version': '1.0',\n\t'sequence': -200,\n\t'author': 'sankalp (schh)',\n\t'category': '',\n\t'installable':True,\n\t'application':True,\n\t'license': 'LGPL-3',\n\t'summary': '',\n\t'data': []\n}"


# ----------------------------------------------    FLOW    ----------------------------------------------------- #
cd odoo/custom
mkdir $MODULE_NAME

echo "Creating $MODULE_NAME module..."

cd $MODULE_NAME
touch $INIT_FILE $MODULE_MANIFEST_FILE
mkdir models static views security data
# echo $ROOT_INIT_IMPORT>>$INIT_FILE
echo -e $MANIFEST_OBJ>>$MODULE_MANIFEST_FILE

echo "Created $MODULE_NAME module succesfully"
echo "Please edit the required files as needed"

# --------------------------------------------- Optional  ------------------------------------------------#
#to run the server with the custom module:

#uncomment if needed
#cd ~
#cd odoo/community
#./odoo-bin --addons-path=addons,../enterprise,../custom -d "DATABASE NAME"
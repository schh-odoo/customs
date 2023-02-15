#!/bin/bash

# Decelaration of all the variables
MODULE_NAME="$1"                                        #MODULE NAME
MODULE_NAME_CAP="$2"                                    #APP NAME
MODEL_NAME="$3"                                         #MODEL UNDERSCORE NAME
MODEL_NAME_PY=$MODEL_NAME.py                            #.py NAME
MODEL_TABLE_NAME=${MODEL_NAME//[_]/.}                   #UNDERSCORE NAME REPLACED WITH .
arr=(${MODEL_NAME//_/ })                                #STORES THE SEPERATED CAPITALISED INDIVIDUAL NAMES
MODEL_CLASS_NAME=`printf %s "${arr[@]^}"`               #MODEL CLASS NAME
INIT_FILE=__init__.py                                   #__INIT__.PY FILE NAME
MODULE_MANIFEST_FILE=__manifest__.py                    #__MANIFEST__.PY FILE NAME
MENU=_menu                                              #CONNECTOR
ROOT=_root_menu                                             #
FIRST=_first_menu                                           #
THIRD=_third_menu                                           #
UNDERSCORE=_                                                #
ACTION=action                                               #
VIEW=view                                                   #
TREE=tree                                               #CONNECTOR
MODEL_VIEW_XML=$MODEL_NAME$UNDERSCORE$VIEW.xml          #MODEL VIEW XML FILE NAME
MENU_XML_FILE=$MODULE_NAME$MENU.xml                     #MODULE MENU XML FILE NAME

#ROOT MENU
MENUITEM="<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<odoo>\n\t<menuitem id=\"$MODEL_NAME$ROOT\" name=\"$MODULE_NAME_CAP\">\n\t\t<menuitem id=\"$MODEL_NAME$FIRST\" name=\"Home\">\n\t\t\t<menuitem id=\"$MODEL_NAME$THIRD\" name=\"$arr\" action=\"$MODEL_NAME$UNDERSCORE$ACTION\" />\n\t\t</menuitem>\n\t</menuitem>\n</odoo>"

SECURITY_FILE="ir.model.access.csv"                     #SECRITY CSV FILE
MODEL_INIT_IMPORT="from . import $MODEL_NAME"           #MODEL IMPORT __INIT__.PY FILE
ROOT_INIT_IMPORT="from . import models"                 #ROOT IMPORT __INIT__.PY FILE

#MANIFEST FILE
MANIFEST_OBJ="{\n\t'name': \"$MODULE_NAME_CAP\",\n\t'depends':['base'],\n\t'version': '1.0',\n\t'sequence': -200,\n\t'author': 'sankalp (schh)',\n\t'category': '',\n\t'installable':True,\n\t'application':True,\n\t'license': 'LGPL-3',\n\t'summary': '',\n\t'data': [\n\t\t'security/ir.model.access.csv',\n\t\t'views/$MODEL_VIEW_XML',\n\t\t'views/$MENU_XML_FILE'\n\t]\n}"

#MODEL
MODEL_OBJ="from odoo import models, fields \n\nclass $MODEL_CLASS_NAME(models.Model):\n\t_name = \"$MODEL_TABLE_NAME\"\n\t_description = \"\" \n\n\tname = fields.Char(required=True)"

#MODEL SECURTIY CSV
MODEL_SECURITY_CSV="$MODULE_NAME.access_$MODEL_NAME,access_$MODEL_NAME,$MODULE_NAME.model_$MODEL_NAME,base.group_user,1,1,1,1"

#MODEL VIEW
MODEL_VIEW="<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<odoo>\n\t<!-- Blank Record -->\n\t<record id=\"$MODEL_NAME$UNDERSCORE$ACTION\" model=\"ir.actions.act_window\">\n\t\t<field name=\"name\">Home</field>\n\t\t<field name=\"res_model\">$MODEL_TABLE_NAME</field>\n\t\t<field name=\"view_mode\">tree,form</field>\n\t\t<field name=\"help\" type=\"html\">\n\t\t\t<p class=\"o_view_nocontent_smiling_face\">\n\t\t\t\tCreate your first property\n\t\t\t</p>\n\t\t</field>\n\t</record>\n\n\t<!-- Tree View -->\n\t<record id=\"$MODEL_NAME$UNDERSCORE$TREE$UNDERSCORE$VIEW\" model=\"ir.ui.view\">\n\t\t<field name=\"name\">$MODEL_NAME$UNDRESCORE$TREE</field>\n\t\t<field name=\"model\">$MODEL_TABLE_NAME</field>\n\t\t<field name=\"arch\" type=\"xml\">\n\t\t\t<tree>\n\t\t\t\t<field name=\"name\" />\n\t\t\t</tree>\n\t\t</field>\n\t</record>\n</odoo>"

# ----------------------------------------------    FLOW    ----------------------------------------------------- #
cd odoo/custom
mkdir $MODULE_NAME

echo "Creating $MODULE_NAME module..."

cd $MODULE_NAME
touch $INIT_FILE $MODULE_MANIFEST_FILE
mkdir models static views security data
echo $ROOT_INIT_IMPORT>>$INIT_FILE
echo -e $MANIFEST_OBJ>>$MODULE_MANIFEST_FILE

cd models
touch $INIT_FILE $MODEL_NAME_PY
echo $MODEL_INIT_IMPORT>>$INIT_FILE
echo -e $MODEL_OBJ>>$MODEL_NAME_PY
cd ..

cd security
touch $SECURITY_FILE
echo "id,name,model_id:id,group_id:id,perm_read,perm_write,perm_create,perm_unlink">>$SECURITY_FILE
echo $MODEL_SECURITY_CSV>>$SECURITY_FILE
cd ..

cd static
mkdir description
cd ..

cd views
touch $MENU_XML_FILE
touch $MODEL_VIEW_XML
echo -e $MENUITEM>>$MENU_XML_FILE
echo -e $MODEL_VIEW>>$MODEL_VIEW_XML
cd ..

echo "Created $MODULE_NAME module succesfully"


# --------------------------------------------- Optional  ------------------------------------------------#
#to run the server with the custom module save:

#uncomment if needed
#cd ~
#cd odoo/community
#./odoo-bin --addons-path=addons,../enterprise,../custom -d "DATABASE NAME"

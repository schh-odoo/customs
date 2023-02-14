#!/bin/bash

MODULE_NAME="$1"
INIT_FILE=__init__.py
MODULE_MANIFEST_FILE=__manifest__.py
MENU=_menu
MENU_XML_FILE=$MODULE_NAME$MENU.xml
echo $MENU_XML_FILE
SECURITY_FILE="ir.model.access.csv"
cd odoo/custom
mkdir $MODULE_NAME
echo "Creating $MODULE_NAME module..."
cd $MODULE_NAME
touch $INIT_FILE $MODULE_MANIFEST_FILE
mkdir models static views security data
cd models
touch $INIT_FILE
cd ..
cd security
touch $SECURITY_FILE
echo "id,name,model_id:id,group_id:id,perm_read,perm_write,perm_create,perm_unlink">>$SECURITY_FILE
cd ..
cd static
mkdir description
cd ..
cd views
touch $MENU_XML_FILE
echo -e "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<odoo>
    <menuitem id=\"\" name=\"\" web_icon=\"$MODULE_NAME,static/description/icon.png\">
        <menuitem id=\"first_level_menu\" name=\"\">
            <menuitem id=\"third_level_home_menu\" name=\"\" action=\"\" />
        </menuitem>
    </menuitem>
</odoo>">>$MENU_XML_FILE
cd ..
echo "Created $MODULE_NAME module succesfully"

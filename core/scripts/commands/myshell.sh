#!/bin/bash
source "$project_path"/core/scripts/functions/colors.sh
# docker
echo ""
red; echo ">"$(blue)"docker";
ls $project_path/modules/docker/
echo -e "\n"
# k8s
#
red; echo ">"$(magenta)"k8s";
ls $project_path/modules/k8s/menus
echo -e "\n"
#
red; echo ">"$(red)"ssh";
ls $project_path/modules/ssh/
echo -e "\n"
# commands
red; echo ">"$(cyan)"Commands";
echo -e \
"mysql_commands     dock    dockrm      crlf_to_lf      clear_ram";
echo -e "\n"
#
#
red; echo ">"$(white)"Help";
echo -e \
"checks - project checks ";
echo -e \
"edit_bash - refresh user bash files from project bash files, start new bash, clear history (.bashrc) ";
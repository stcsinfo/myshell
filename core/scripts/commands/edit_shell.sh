#!/bin/zsh
chown -R $USER:$USER $project_path/
chmod -R u+rwx,g+rw-x,o-rwx $project_path/
cp -rf $project_path/core/zsh/.zshrc $HOME/
cp -rf $project_path/core/bash/.bashrc $HOME/
$shell_version
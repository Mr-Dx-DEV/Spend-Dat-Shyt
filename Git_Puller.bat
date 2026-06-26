@echo off
TITLE Git Auto Pull - Inspire Main 
color a
:start
git pull 
timeout 120
GOTO start
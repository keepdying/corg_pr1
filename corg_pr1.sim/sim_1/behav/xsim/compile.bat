@echo off
REM ****************************************************************************
REM Vivado (TM) v2017.4 (64-bit)
REM
REM Filename    : compile.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for compiling the simulation design source files
REM
<<<<<<< HEAD
REM Generated by Vivado on Tue May 10 21:06:55 +0300 2022
=======
REM Generated by Vivado on Tue May 10 19:02:15 +0300 2022
>>>>>>> 602429d015b32bca45360917a2fc737ae11a26b8
REM SW Build 2086221 on Fri Dec 15 20:55:39 MST 2017
REM
REM Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
REM
REM usage: compile.bat
REM
REM ****************************************************************************
echo "xvlog --incr --relax -prj reg_arf_test_vlog.prj"
call xvlog  --incr --relax -prj reg_arf_test_vlog.prj -log xvlog.log
call type xvlog.log > compile.log
if "%errorlevel%"=="1" goto END
if "%errorlevel%"=="0" goto SUCCESS
:END
exit 1
:SUCCESS
exit 0

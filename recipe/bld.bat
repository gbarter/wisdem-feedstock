@echo on

cd %SRC_DIR%
set NP_INC=%SP_DIR%\numpy\core\include
REM set CC=cl
REM set FC=flang
REM set CC_LD=link

REM See the unix build.sh for more details on the build process below.
set MESON_ARGS=-Dincdir_numpy=%NP_INC% -Dpython_target=%PYTHON% %EXTRA_FLAGS%
%PYTHON% -m build -n -x .
%PYTHON% -m pip install --prefix "%PREFIX%" --no-deps --no-index --find-links dist wisdem
REM %PYTHON% setup.py install --single-version-externally-managed --record=record.txt

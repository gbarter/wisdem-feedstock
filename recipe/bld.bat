@echo on

cd %SRC_DIR%
set NP_INC=%SP_DIR%\numpy\core\include
REM set CC=cl
REM set FC=flang
REM set CC_LD=link

REM See the unix build.sh for more details on the build process below.
set MESON_ARGS=-Dincdir_numpy=%NP_INC% -Dpython_target=%PYTHON% %EXTRA_FLAGS%

python -m build -n -x -w .
REM %PYTHON% -m pip install --prefix "%PREFIX%" --no-deps dist/wisdem-3.9-py3-none-any.whl
REM %PYTHON% setup.py install --single-version-externally-managed --record=record.txt
REM pip install --prefix "%PREFIX%" --no-deps --no-index --find-links dist pyoptsparse
REM `pip install dist\numpy*.whl` does not work on windows,
REM so use a loop; there's only one wheel in dist/ anyway
for /f %%f in ('dir /b /S .\dist') do (
    REM need to use force to reinstall the tests the second time
    REM (otherwise pip thinks the package is installed already)
    %PYTHON% -m pip install --prefix "%PREFIX%" --no-deps %%f
    if %ERRORLEVEL% neq 0 exit 1
)
rmdir /s /q %SP_DIR%\meson_build

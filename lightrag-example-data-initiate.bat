@echo off
REM 文件需保存为 UTF-8 with BOM 编码

REM 设置 CMD 代码页为 UTF-8
chcp 65001 > nul

set PY_SCRIPT=C:\Python-Learning\lightRAG\LightRAG\examples\milvus_neo4j_operation.py
set PROJECT_DIR=C:\Python-Learning\lightRAG\LightRAG

REM 激活Conda环境
echo 正在激活Conda环境...
call conda activate lightrag
if errorlevel 1 (
    echo [ERROR] Conda激活失败，请检查环境名称或路径
    exit /b 1
)

REM 切换目录到项目根路径
echo 正在切换目录到项目根路径...
cd /d "%PROJECT_DIR%"
if errorlevel 1 (
    echo [ERROR] 目录 "%PROJECT_DIR%" 不存在
    exit /b 1
)

REM 重置Milvus
echo 正在重置Milvus...
python "%PY_SCRIPT%" "start_milvus"
if errorlevel 1 (
    echo [ERROR] start_milvus失败，请检查日志
    exit /b 1
)


REM 删除Neo4j数据
echo 正在删除Neo4j数据...
python "%PY_SCRIPT%" "insert_neo4j_data"
if errorlevel 1 (
    echo [ERROR] 删除Neo4j数据失败，请检查Neo4j服务
    exit /b 1
)


echo 所有操作已完成！
pause



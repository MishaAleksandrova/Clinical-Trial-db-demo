import os
import psycopg2

def run_sql_file(filepath):
    with open(filepath, encoding='utf-8') as file:
        sql = file.read()

    conn = psycopg2.connect(
        dbname="clinical_trail_db",
        user="postgres",
        password="postgres",
        host="localhost",
        port="5432"
    )
    conn.set_isolation_level(psycopg2.extensions.ISOLATION_LEVEL_AUTOCOMMIT)
    cur = conn.cursor()

    try:
        print(f'▶ Executing {filepath}')
        cur.execute(sql)
        print(f'✅ Completed {filepath}\n')
    except Exception as error:
        print(f'❌ Error in {filepath}:', error)
        conn.rollback()
    finally:
        cur.close()
        conn.close()

def run_all_views(directory='views'):
    for filename in sorted(os.listdir(directory)):
        if filename.endswith('.sql'):
            run_sql_file(os.path.join(directory, filename))

if __name__ == '__main__':
    run_all_views()
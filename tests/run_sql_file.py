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

        if 'select' in sql.lower():
            try:
                results = cur.fetchall()
                for row in results:
                    print("🧪", row[0])
            except psycopg2.ProgrammingError:
                pass  # no results to fetch

        print(f'✅ Completed {filepath}\n')
    except Exception as error:
        print(f'❌ Error in {filepath}:', error)
        conn.rollback()
    finally:
        cur.close()
        conn.close()

def run_multiple_sql_files(files):
    for f in files:
        run_sql_file(f)

if __name__ == '__main__':
    run_multiple_sql_files([
        'test_add_new_patient.sql',
        'test_assign_investigator.sql',
        'test_log_lab_result.sql',
        'test_record_medication.sql',
        'test_report_adverse_event.sql',
        # 'test_setup.sql',
    ])
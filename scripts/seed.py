import psycopg2
from datetime import date

def seed_initial_data():
    print("Connecting to the pgvector database...")
    try:
        # 1. Connect to the Docker Postgres container using the credentials from docker-compose
        conn = psycopg2.connect(
            host="127.0.0.1",
            port=5433,
            user="postgres",
            password="postgres",
            database="mydb"
        )
        cursor = conn.cursor()

        # 2. Create the tables manually for this Week 1 smoke test
        print("Creating temporary tables for infrastructure and applications...")
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS infrastructure (
                id VARCHAR(50) PRIMARY KEY,
                os_name VARCHAR(100),
                os_eol_date DATE,
                environment_type VARCHAR(50)
            );
        """)
        
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS applications (
                id VARCHAR(50) PRIMARY KEY,
                name VARCHAR(100),
                archetype VARCHAR(50),
                language VARCHAR(50),
                runtime_version VARCHAR(50),
                criticality VARCHAR(50),
                owner_team VARCHAR(50),
                infrastructure_id VARCHAR(50)
            );
        """)

        # 3. Insert your Carbon Black App Control real-world test case
        print("Seeding Carbon Black environment data...")
        
        infra_id = "infra-cb-prod"
        cursor.execute("""
            INSERT INTO infrastructure (id, os_name, os_eol_date, environment_type)
            VALUES (%s, %s, %s, %s)
            ON CONFLICT (id) DO NOTHING;
        """, (infra_id, "Windows Server 2012 R2", date(2023, 10, 10), "On-Prem VM"))

        cursor.execute("""
            INSERT INTO applications (id, name, archetype, language, runtime_version, criticality, owner_team, infrastructure_id)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            ON CONFLICT (id) DO NOTHING;
        """, ("app-carbon-black", "Carbon Black App Control", "Vendor COTS Application", "C++", "Native", "Mission Critical", "AppSec Infrastructure Team", infra_id))

        # 4. Commit transactions and safely close connection
        conn.commit()
        print("Success! Database has been seeded with your initial test cases.")
        
    except Exception as e:
        print(f"An error occurred while seeding the database: {e}")
    finally:
        if 'conn' in locals():
            cursor.close()
            conn.close()

if __name__ == "__main__":
    seed_initial_data()
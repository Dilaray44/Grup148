from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker


# İki adet DB kullandım bu db lerden biri iş hakkında bilgilerin tutulmasını sağlarken diğeri de USERS,USERS PROJECT ve PROJECT CONVERSATIONS tablolarını tutacak
# Burada iki db kullanmamadaki neden Job bilgilerini diğer bilgilerden ayırmaktı. Diğerlerini DB yapmadım çünkü db leri bağlamak çok sıkıntılı ve PostgreSQL
# kapazite olarak daha iyi bir iş çıkartıyormuş.

# İş Açıklamaları db'si
SQLALCHEMY_DATABASE_URL1 = "sqlite:///./JOB_SUMMARIES.db"
# SQLALCHEMY_DATABASE_URL1 = "postgresql://user:password@postgreserver/db"

engine1 = create_engine(
    SQLALCHEMY_DATABASE_URL1, connect_args={"check_same_thread": False}
)

SessionLocal1 = sessionmaker(autocommit=False, autoflush=False, bind=engine1)

Base1 = declarative_base()

# Projeler db'si
SQLALCHEMY_DATABASE_URL2 = "sqlite:///./PROJECTS.db"
# SQLALCHEMY_DATABASE_URL2 = "postgresql://user:password@postgreserver/db"

engine2 = create_engine(
    SQLALCHEMY_DATABASE_URL2, connect_args={"check_same_thread": False}
)

SessionLocal2 = sessionmaker(autocommit=False, autoflush=False, bind=engine2)

Base2 = declarative_base()

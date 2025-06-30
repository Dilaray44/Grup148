from database import Base1,Base2
from sqlalchemy import Column, Integer, String, Boolean, ForeignKey,Date

class Jobs(Base1):
    __tablename__ = 'JOBS'

    index = Column(Integer,primary_key=True,index=True)
    date = Column(Date)
    local_address = Column(String)
    region = Column(String)
    sector = Column(String)
    description = Column(String)
    level = Column(String)
    title = Column(String)


#Authentication için sınıf oluştururuz.Bir neviburada database oluşturuyoruz
# Class ta yaptıklarımızın Fastapi ye yansıması için migration işlemi yapmamız gerekir.
#Eğer migration işlemiyle uğraşmak istemiyorsak refactor yaparız yani reset çekeriz.


# Bu kısım yapılacak
class User(Base2):
    __tablename__ = 'USERS'

    id = Column(Integer,primary_key=True,index=True)
    email = Column(String,unique=True)
    username = Column(String, unique=True)
    first_name = Column(String)
    last_name = Column(String)
    hashed_password = Column(String) #Parolalar hiçbir zaman açık metin olarak tutulmamalıdır.
    is_active = Column(Boolean,default=True) #Bir kaç uygulamada böyle işlemlerde var.
    phone_number =Column(String)


class Project(Base2):
    __tablename__ = 'USERS_PROJECTS'

    id = Column(Integer,primary_key=True,index=True)
    user_id = Column(Integer,ForeignKey('USERS.id'))
    project_title = Column(String)
    project_description = Column(String)
    sector = Column(String)
    created_at = Column(Date)


class Conversation(Base2):
    __tablename__ = 'PROJECT_CONVERSATIONS'
    id = Column(Integer,primary_key=True,index=True)
    project_id = Column(Integer,ForeignKey('USER_PROJECTS.id'))
    message_type = Column(String,nullable=False)
    content = Column(String)
    timestamp = Column(Date)
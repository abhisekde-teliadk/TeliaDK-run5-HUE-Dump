# dump_hue_metastore.py
# Migration tool to extract user scripts from HUE metastore.
# abhisek.de@teliacompany.com

import mysql.connector
from mysql.connector import Error
import json
import os
import codecs

def file_io(_path, t_flag, f_data=None):
    '''
    File IO: Create user directory and generate data files.
    file_io(_path, _type_flag, _text_string)
    _type_flag = [f, d]
    '''
    try:
        if not os.path.exists(_path) and t_flag == 'd':
            os.mkdir(_path)
            print "Folder", _path
        elif t_flag == 'f':
            fo = codecs.open(_path, "w", "utf-8")
            fo.write(f_data)
            fo.close()
    except OSError as e2:
        print "OS Error", e2
        
def exec_sql(sql_select_query):
    '''
    Execute SQL: MySQL sql string execution. Connection is hard coded.
    This function doesn't perform validation check for SQL string.
    Returns a tuple on successful execution, else returns a None object
    '''
    records = None
    try:
    # Connect
    # I know this is bad, don't curse me! This is a one time thing (0_o)
        connection = mysql.connector.connect(host='mydbrun5d.c4wxxbxxfqvz.eu-west-1.rds.amazonaws.com', database='huedb_3oujq8llb183ut5vmo20mq61d4', user='dbroot', password='34jkhljui431p')    
                                         
        cursor = connection.cursor()
        cursor.execute(sql_select_query)
        records = cursor.fetchall()
    except Error as e:
        print "DB Error", e
    finally:
        if(connection.is_connected()):
            connection.close()
            cursor.close()
    
    return records
    
def parse_json(rdata):
    '''
    Parse JSON: Parses JSON string to fetch statement_raw.
    Returns string text upon successful execution, else returns a null string.
    '''
    d = ''
    try:
        jdata = json.loads(rdata)
        d = jdata['snippets'][0]['statement_raw']

    except KeyError as e3:
       print "JSON Error", e3
       d = ''
    except ValueError as e4:
       print "JSON Error", e4
       
    return d

# MAIN
# ----
APP_HOME = os.getcwd()   

# Make user directory
dir_query = "select username from auth_user"
records = exec_sql(dir_query)
for row in records:
    dir_name = APP_HOME + os.sep + row[0] 
    file_io(dir_name.encode('ascii','ignore'), 'd', None)

# Create user documents            
data_query = '''select t3.file_name, desktop_document2.data 
from (
select concat(concat(concat(username, "/"), replace(replace(name, ' ', '_'), '/', '_')), ".sql") file_name, file_id
from (
select name, max(object_id) "file_id", username
from (
select desktop_document.name, desktop_document.object_id, auth_user.username 
from auth_user join desktop_document on desktop_document.owner_id = auth_user.id 
where desktop_document.name != "" and desktop_document.name != ".Trash" 
) t1 group by name
) t2
) t3 join desktop_document2 on desktop_document2.id = t3.file_id'''
records = exec_sql(data_query)
print "Dumping HUE document:"
for row in records:
    f_name = row[0]
    file_name = APP_HOME + os.sep + f_name
    print "File", file_name 
    d_data = parse_json(row[1])
    if len(d_data) > 0:
        file_io(file_name.encode('ascii','ignore'), 'f', d_data)
    else:
        print "No document created for file", f_name

print "Done."

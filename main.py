from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import config
import database
from queries import themepark_queries
from queries import coaster_queries

app = FastAPI(docs_url=config.documentation_url)

origins = config.cors_origins.split(",")
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/createDatabase")
def insert_coasters_from_SQL_file():
    with open('sql_files/coasters.sql', "r", encoding="utf-8") as sql_file:
        sql_queries = sql_file.read()

    success = database.execute_sql_query(sql_queries)
    return {"success": success}

@app.get("/themeparks")
def get_all_themeparks():
    query = themepark_queries.all_themeparks
    themeparks = database.execute_sql_query(query)
    if isinstance(themeparks, Exception):
        return themeparks, 500
    themeparks_to_return = []
    for themepark in themeparks:
        themeparks_to_return.append(themepark[0])
    return({'themeparks': themeparks_to_return})


@app.get("/themeparks/detail")
def get_all_themeparks_detail():
    query = themepark_queries.all_themeparks_detail
    themeparks = database.execute_sql_query(query)
    if isinstance(themeparks, Exception):
        return themeparks, 500
    themeparks_to_return = []
    for themepark in themeparks:
        themepark_dictionary = {"name": themepark[0], "openingDate": themepark[1], "city": themepark[2], "website": themepark[3]}
        themeparks_to_return.append(themepark_dictionary)
    return({'themeparks': themeparks_to_return})


@app.get("/themeparks/opening")
def get_themeparks_by_year(year: int):
    query = themepark_queries.themeparks_by_year
    themeparks = database.execute_sql_query(query, [year])
    if isinstance(themeparks, Exception):
        return themeparks, 500
    themeparks_to_return = []
    for themepark in themeparks:
        themepark_dictionary = {"name": themepark[0], "openingDate": themepark[1], "city": themepark[2], "website": themepark[3]}
        themeparks_to_return.append(themepark_dictionary)
    return({'themeparks': themeparks_to_return})

@app.get("/coasters/inversions")
def coasters_by_inversions(number: int = 1):
    query = coaster_queries.coasters_by_inversions
    coasters = database.execute_sql_query(query, [number])
    if isinstance(coasters, Exception):
        return coasters, 500
    coasters_to_return = []
    for coaster in coasters:
        coaster_dictionary = {"name": coaster[0], "length": coaster[1], "height": coaster[2], "maximumSpeed": coaster[3], "inversions": coaster[4]}
        coasters_to_return.append(coaster_dictionary)
    return({'rollercoasters': coasters_to_return})

@app.get("/coasters")
def coasters_by_id(coasterID: int):
    query = coaster_queries.coasters_by_id
    coaster = database.execute_sql_query(query, [coasterID])
    if isinstance(coaster, Exception):
        return coaster, 500
    if not coaster: return {}

    coaster = coaster[0]
    coaster_dictionary = {"name": coaster[1], "length": coaster[2], "height": coaster[3], "maximumSpeed": coaster[4], "inversions": coaster[5]}

    return coaster_dictionary

@app.get("/themeparks/coasters")
def themeparks_by_id(themeParkID: int):
    query = themepark_queries.themepark_by_id
    themepark = database.execute_sql_query(query, [themeParkID])
    if isinstance(themepark, Exception):
        return themepark, 500
    if not themepark: return {}


    themepark_info = {"name": themepark[0][1], "website": themepark[0][2], "coasters": []}

    for coaster in themepark:
        coaster = {
            "name": coaster[3],
            "length": coaster[4],
            "height": coaster[5],
            "maximumSpeed": coaster[6],
            "inversions": coaster[7],
        }
        themepark_info["coasters"].append(coaster)

    return themepark_info
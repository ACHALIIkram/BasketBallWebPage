# app/main.py
from fastapi import FastAPI
from app.db.db import engine, Base
from app.api import user, match, team, statistics, player, admin, training
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from pathlib import Path
import os

app = FastAPI()

app.mount("/assets", StaticFiles(directory=os.path.join(os.path.dirname(__file__), "assets")), name="assets")

#  CORS Configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Create tables on startup
@app.on_event("startup")
async def startup():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

@app.on_event("shutdown")
async def shutdown():
    await engine.dispose()


# Include the user API router
app.include_router(user.router, prefix="/api/users", tags=["Users"])

# Include the match API router
app.include_router(match.router, prefix="/api/matches", tags=["Matches"])

# Include the team API router
app.include_router(team.router, prefix="/api/teams", tags=["Teams"])

# Include the statistics API router
app.include_router(statistics.router, prefix="/api/statistics", tags=["Statistics"])

# Include the player API router
app.include_router(player.router, prefix="/api/players", tags=["Players"])

# Include the admin API router
app.include_router(admin.router, prefix="/api/admin", tags=["Admin"])

# Include the training API router
app.include_router(training.router, prefix="/api/training", tags=["Training"])

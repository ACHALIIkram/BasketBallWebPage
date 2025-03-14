from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from ..services.user_service import (
    get_users,
    get_user,
    create_user,
    update_user,
    delete_user,
    get_session,
    get_users_by_team,
    remove_user_from_team
)
from ..models.schemas import UserCreate, User

router = APIRouter()

# CRUD - Read all users
@router.get("/users", response_model=list[User])
async def read_users(session: AsyncSession = Depends(get_session)):
    """Retrieve all users."""
    return await get_users(session)

# CRUD - Read a specific user by ID
@router.get("/users/{user_id}", response_model=User)
async def read_user(user_id: int, session: AsyncSession = Depends(get_session)):
    """Retrieve a specific user by ID."""
    user = await get_user(session, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user

# CRUD - Create a new user
@router.post("/users", response_model=User)
async def create_user_api(user: UserCreate, session: AsyncSession = Depends(get_session)):
    """Create a new user."""
    return await create_user(session, user)

# CRUD - Update an existing user
@router.put("/users/{user_id}", response_model=User)
async def update_user_api(user_id: int, user: UserCreate, session: AsyncSession = Depends(get_session)):
    """Update an existing user."""
    updated_user = await update_user(session, user_id, user)
    if not updated_user:
        raise HTTPException(status_code=404, detail="User not found")
    return updated_user

# CRUD - Delete a user
@router.delete("/users/{user_id}")
async def delete_user_api(user_id: int, session: AsyncSession = Depends(get_session)):
    """Delete a user."""
    deleted_user = await delete_user(session, user_id)
    if not deleted_user:
        raise HTTPException(status_code=404, detail="User not found")
    return {"message": "User deleted successfully"}


# CRUD - Get all users by team ID
@router.get("/users/team/{team_id}", response_model=list[User])
async def get_users_by_team_api(team_id: int, session: AsyncSession = Depends(get_session)):
    users = await get_users_by_team(session, team_id)
    return users


# CRUD - Remove user from a team
@router.delete("/users/{user_id}/team", response_model=User)
async def remove_user_from_team_api(user_id: int, session: AsyncSession = Depends(get_session)):
    """Remove a user from a team by setting their idTeam to None."""
    removed_user = await remove_user_from_team(session, user_id)
    if not removed_user:
        raise HTTPException(status_code=404, detail="User not found")
    return removed_user
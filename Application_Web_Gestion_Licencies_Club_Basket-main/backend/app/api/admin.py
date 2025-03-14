from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from ..services.admin import (
    login,
    get_session
)
from ..models.schemas import LoginRequest

router = APIRouter()

@router.post("/login")
async def login_api(request: LoginRequest, session: AsyncSession = Depends(get_session)):
    return await login(session, request)
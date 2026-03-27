import { Router } from "express"
import {getMessage} from "../controllers/app.controller";

const appRouter = Router()

appRouter.get("/", getMessage)

export default appRouter
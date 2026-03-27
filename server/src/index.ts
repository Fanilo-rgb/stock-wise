import "dotenv/config"

import express from "express"
import cors from "cors"
import appRouter from "./routes/app.routes";
import errorHandler from "./middleware/errorHandler";

const PORT = 4004
const NODE_ENV = "environment"

const app = express()

app.use(express.json())
app.use(express.urlencoded({ extended: true }))

// your app origin url
// app.use(
//   cors({
//     origin: "http://localhost:5123"
//   })
// )

app.use("/", appRouter)

app.use(errorHandler)

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT} in ${NODE_ENV} mode`)
})

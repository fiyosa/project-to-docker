import express, { Application, Request, Response, NextFunction } from 'express'
import bodyParser from 'body-parser'
import cors from 'cors'
import dotenv from 'dotenv'
dotenv.config()

const app: Application = express()
const PORT: string | number = process.env.PORT || 4000

app.use('*', cors())
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: false }))

app.use((_: Request, res: Response, next: NextFunction) => {
  res.setHeader('Access-Control-Allow-Origin', '*')
  res.setHeader('Access-Control-Allow-methods', 'GET, POST, PUT, PATCH, DELETE, OPTION')
  res.setHeader('Access-Control-Allow-Headers', 'Authorization, Accept , Content-Type')
  next()
})

app.get('/', (_: Request, res: Response) => {
  return res.json({
    success: true,
    message: 'hello world',
  })
})

app.listen(PORT, () => {
  console.log(`http://localhost:${PORT}`)
})

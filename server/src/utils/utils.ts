import {NextFunction, Request, Response} from "express";

export interface CustomError extends Error {
  statusCode?: number
}

type createErrorType = (message: string, statusCode: number) => CustomError

type AsyncController = (
  req: Request,
  res: Response,
  next: NextFunction
) => Promise<any>;

const catchErrors = (controller: AsyncController): AsyncController =>
  async (req, res, next) => {
    try {
      await controller(req, res, next)
    } catch (e) {
      next(e)
    }
  }

const createError: createErrorType = (message, statusCode) => {
  const error: CustomError = new Error(message)
  error.statusCode = statusCode
  return error
}

export { catchErrors, createError };
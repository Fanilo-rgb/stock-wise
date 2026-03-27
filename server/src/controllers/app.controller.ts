import {catchErrors} from "../utils/utils";

import {OK} from "../constants/http";

const getMessage = catchErrors(async (req, res) => {
  return res.status(OK).send({
    success: true,
    message: "Express base folder run smoothly"
  })
})

export { getMessage }
const express = require('express');
const authRouter = require('./router/auth');
const mongoose = require('mongoose');
const app = express();
const adminRouter = require('./router/admin');
const productRouter = require('./router/product');
const userRouter = require('./router/user');
const PORT = process.env.PORT || 3000;
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);
const DB =
  'mongodb+srv://taha:taha123@cluster0.sh9hs0o.mongodb.net/?retryWrites=true&w=majority';
mongoose
  .connect(DB)
  .then(() => {
    console.log('Successful Connected');
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Conntected to ${PORT}`);
});

const mongoose = require('mongoose');
const authRouter = require('../router/auth');
const { productSchema } = require('./product');

const userSchema = mongoose.Schema({
  name: {
    required: true,
    trim: true,
    type: String,
  },
  email: {
    required: true,
    trim: true,
    type: String,
    validate: {
      validator: (value) => {
        const re =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(re);
      },
      message: 'Please Enter all valide',
    },
  },
  password: {
    required: true,
    type: String,
  },
  type: {
    type: String,
    default: 'user',
  },
  address: {
    type: String,
    default: '',
  },
  cart: [
    {
      product: productSchema,
      quantity: {
        type: Number,
        required: true,
      },
    },
  ],
});

const User = mongoose.model('User', userSchema);

module.exports = User;

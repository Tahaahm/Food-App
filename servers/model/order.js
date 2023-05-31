const mogoose = require('mongoose');
const { productSchema } = require('./product');

const orderSchema = mogoose.Schema({
  products: [
    {
      product: productSchema,
      quantity: {
        type: Number,
        required: true,
      },
    },
  ],
  totalPrice: {
    type: Number,
    required: true,
  },
  address: {
    type: String,
    required: true,
  },
  userId: {
    required: true,
    type: String,
  },
  orderedAt: {
    type: Number,
    required: true,
  },
  status: {
    type: Number,
    defualt: 0,
  },
});

const Order = mogoose.model('Order', orderSchema);
module.exports = Order;

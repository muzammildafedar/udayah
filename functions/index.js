require('dotenv').config();
const express = require('express');
const cors = require('cors');
const app = express();
const port = process.env.PORT || 3000;
const hrEmailRoutes = require('./routes/hrEmailRoutes');
const sendEmailRoutes = require('./routes/sendEmailRoutes');


app.use(cors({
  origin: '*', // Update if needed
  methods: 'GET, POST, PUT, DELETE, OPTIONS',
  allowedHeaders: 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
}));
// app.use('/.well-known', express.static(path.join(__dirname, '.well-known')));
//app.use(cors());
app.use(express.json());
app.get('/', async (req, res) => {
  res.status(200).json({ success: 'Working bro..' });
});
//app.us('/.well-known', express.static(path.join(__dirname, '.well-known')));


//routers
app.use(hrEmailRoutes);
app.use(sendEmailRoutes);



app.listen(port, () => {
  console.log('Server running on port 3000');
});

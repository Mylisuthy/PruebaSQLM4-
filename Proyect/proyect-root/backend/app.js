// principal server for the backend
require('dotenv').config()
const express = require('express')
const cors = require('cors')
const morgan = require('morgan')
const jwt = require('jsonwebtoken')
const validator = require('validator')
const helmet = require('helmet')

// API ROUTES
const estudiantesRouter = require('./apy/Masive')
const genericRouter = require('./apy/Conect')

const app = express();

// HTTP safety headers
app.use(helmet());

// restrictive CORS
app.use(cors({
  origin: process.env.FRONTEND_URL || 'http://localhost:5173',
  credentials: true
}));
app.use(express.json())
app.use(morgan('dev'))

// Middleware autentification JWT
function authMiddleware(req, res, next) {
  const authHeader = req.headers.authorization
  if (!authHeader) return res.status(401).json({ error: 'Token is required' })
  const token = authHeader.split(' ')[1]
  jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
    if (err) return res.status(403).json({ error: 'Token is not valid' })
    req.user = user
    next()
  })
};

// Basic protection XSS
app.use(express.json({
  verify: (req, res, buf) => {
    const str = buf.toString('utf8')
    if (/<script>|<\/script>/i.test(str)) {
      throw new Error('Payload suspicious for XSS')
    }
  }
}));

// Protected routes
app.use('/api/Masive', authMiddleware, estudiantesRouter)
app.use('/api/generic', authMiddleware, genericRouter)

// Endpoint de métricas (ejemplo)
app.get('/api/metrics', authMiddleware, async (req, res) => {
  const supabase = require('./supabase_client')
  // all customers
  const { count: allCustomer } = await supabase.from('customer').select('*', { count: 'exact', head: true })
  // all bill
  const { count: allBill } = await supabase.from('bill').select('*', { count: 'exact', head: true })
  res.json({ totalEstudiantes, totalCursos })
});

// Centralized error handling
app.use((err, req, res, next) => {
  console.error(err)
  res.status(500).json({ error: 'Error interno del servidor' })
});

const PORT = process.env.PORT || 3000
app.listen(PORT, () => {
  console.log(`Servidor backend escuchando en puerto ${PORT}`)
});


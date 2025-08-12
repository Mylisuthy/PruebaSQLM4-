const express = require('express')
const router = express.Router()
const supabase = require('../supabase_client')
const validator = require('validator')

// Obtener todos los estudiantes
router.get('/', async (req, res) => {
  try {
    const { data, error } = await supabase.from('costumer').select('*')
    if (error) throw error
    res.json(data)
  } catch (err) {
    res.status(500).json({ error: 'costumer catch error' })
  }
})

module.exports = router

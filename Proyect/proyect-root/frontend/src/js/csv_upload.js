import Papa from 'papaparse'
import axios from 'axios'

const input = document.getElementById('csvInput')
const token = localStorage.getItem('token')

function escapeHTML(str) {
  return str.replace(/[&<>"']/g, function (m) {
    return ({
      '&': '&amp;',
      '<': '&lt;',
      '>': '&gt;',
      '"': '&quot;',
      "'": '&#39;'
    })[m]
  })
}

// CSV TRANSLATE
input.addEventListener('change', (e) => {
  const file = e.target.files[0]
  if (!file) return
  Papa.parse(file, {
    header: true,
    skipEmptyLines: true,
    complete: async function(results) {

      const estudiantes = results.data
        .map(row => ({
          ...row,
          id_customer: escapeHTML(row.id_customer || ''),
          transaction_datetime: escapeHTML(row.transaction_datetime || ''),
          amount: escapeHTML(row.amount || ''),
          status: escapeHTML(row.status || ''),
          transaction_type: (row.transaction_type || ''),
          first_name: escapeHTML(row.first_name || ''),
          last_name: escapeHTML(row.last_name || ''),
          num_identification: escapeHTML(row.num_identification || ''),
          address: escapeHTML(row.address || ''),
          phone_number: escapeHTML(row.phone_number || ''),
          email: escapeHTML(row.email || ''),
          platform_used: escapeHTML(row.platform_used || ''),
          Invoice_number: escapeHTML(row.Invoice_number || ''),
          billing_period: escapeHTML(row.billing_period || ''),
          invoiced_amount: escapeHTML(row.invoiced_amount || ''),
          amount_paid: escapeHTML(row.amount_paid || ''),
        }))
        .filter(row =>
          row.nombre && row.apellido && row.matricula && row.email
        )
      if (estudiantes.length === 0) {
        alert('El archivo no contiene registros válidos.')
        return
      }
      try {
        const res = await axios.post('http://localhost:3000/api/generic/estudiantes', estudiantes, {
          headers: { Authorization: `Bearer ${token}` }
        })
        alert('Carga exitosa')
      } catch (err) {
        if (err.response && err.response.data && err.response.data.error) {
          alert('Error: ' + err.response.data.error)
        } else {
          alert('Error en carga masiva')
        }
      }
    }
  })
})

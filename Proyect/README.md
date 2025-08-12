# Proyecto Full Stack

## Carga masiva de datos

se intento lograr su funcionamiento pero fue imposible encriptar el error

## Seguridad

- Todas las rutas protegidas requieren JWT.
- Validación y sanitización de entradas en backend y frontend.
- Políticas RLS activas en la base de datos.
- Se recomienda usar HTTPS y restringir CORS en producción.

## Seguridad avanzada

- **CORS**: Solo permite solicitudes desde el frontend configurado.
- **Helmet**: Añade cabeceras HTTP seguras.
- **XSS**: Se rechazan payloads con `<script>` en el backend.
- **CSRF**: Se recomienda usar tokens CSRF si se usan cookies/sesiones.
- **RLS**: Políticas de Row Level Security activas en la base de datos.
- **Validación y sanitización**: Todas las entradas se validan en backend y frontend.

## Estructura

- `/backend/apy/Masive.js`: Endpoint `/bulk` para carga masiva.
- `/frontend/src/js/csv_upload.js`: Lógica de carga y validación de CSV.

## Recomendaciones de despliegue

- Usar HTTPS en producción.
- Configurar variables de entorno seguras.
- Revisar y ajustar las políticas RLS según el dominio.

## Pruebas extremas recomendadas

- **Carga masiva con datos corruptos:**  
  Subir un CSV con campos vacíos, fechas mal formateadas o duplicados. El backend debe rechazar los registros inválidos y mostrar el error correspondiente.
- **Inyección de scripts en formularios:**  
  Intentar enviar `<script>alert(1)</script>` en cualquier campo de texto. El backend debe rechazar el payload y el frontend debe sanitizar la entrada.
- **Carga masiva con más de 1000 registros:**  
  Verificar que el sistema maneje correctamente grandes volúmenes y reporte errores si se supera el límite permitido.

## Seguridad en el frontend

- **Sanitización de entradas:**  
  Utiliza funciones de escape en los formularios antes de enviar datos al backend.
- **Almacenamiento seguro del token:**  
  El token JWT se guarda en `localStorage` y se envía solo por header Authorization.
- **Protección XSS:**  
  Nunca insertes datos del usuario directamente en el DOM sin sanitizar.
- **CORS:**  
  El backend solo acepta solicitudes del dominio frontend configurado.

**Nombre:** juan david gonzalez hincapie
**clan:** linus
**correo:** juanch052048@gmail.com
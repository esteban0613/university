# 📱 Flutter University App

Aplicación en Flutter que muestra una lista de universidades, permitiendo cambiar entre vista de lista y grilla, con paginación local (infinite scroll), y detalle de cada universidad con opciones para subir una imagen y registrar número de estudiantes.

---

## 🚀 Características

- Carga de universidades desde JSON remoto.
- Vista en `ListView` o `GridView`, con cambio dinámico.
- Infinite Scroll sin librerías externas (20 ítems por carga).
- Detalle de universidad:
  - Subida de imagen desde galería o cámara.
  - Ingreso de número de estudiantes con validación.
- Estado mantenido en memoria (no persistente).
- Arquitectura modular con enfoque en Clean Code.

---

## 📂 Estructura del proyecto

```bash
lib/
├── core/
│   └── widgets/
├── features/
│   └── universities/
│       ├── data/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   └── entities/
│       └── presentation/
│           ├── screens/
│           └── widgets/

🧪 Consideraciones
No se guarda la imagen ni los datos de estudiantes entre sesiones.

Los datos vienen del JSON:
https://tyba-assets.s3.amazonaws.com/FE-Engineer-test/universities.json

🧠 Autor
Desarrollado por Juan Esteban Moreno como parte de una prueba técnica en Flutter.
Contacto: esteban1306@gmail.com


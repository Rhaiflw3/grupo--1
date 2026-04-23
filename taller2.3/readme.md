<div align="center">
  <h1>📊 Guía de Laboratorio N°11</h1>
  <p><i>Dominio de Vistas y Modelado Físico en PL/SQL</i></p>
</div>

---

<table>
  <tr>
    <td width="50%" valign="top">
      <h3>1️⃣ ¿Qué es una Vista?</h3>
      <p>Es una "tabla virtual" basada en el resultado de una consulta SQL. No almacena datos físicamente, sino que funciona como un acceso directo dinámico.</p>
<pre><code>CREATE VIEW nombre_vista AS
SELECT columnas FROM tabla;</code></pre>
    </td>
    <td width="50%" valign="top">
      <h3>2️⃣ Modelo Físico</h3>
      <p>Implementación de la base de datos <strong>Diagnósticos</strong>. Incluye tablas de Pacientes, Médicos, Especialidades y su relación mediante llaves foráneas.</p>
    </td>
  </tr>
  <tr>
    <td valign="top">
      <h3>3️⃣ Vista v_pacienteEnfermedad</h3>
      <p>Une 4 tablas mediante <strong>JOIN</strong> para relacionar pacientes con sus enfermedades diagnosticadas de forma automática.</p>
    </td>
    <td valign="top">
      <h3>4️⃣ Lógica de Exclusión</h3>
      <p>Uso de <strong>NOT IN</strong> para detectar:</p>
      <ul>
        <li>Enfermedades nunca detectadas.</li>
        <li>Especialidades sin médicos.</li>
        <li>Pacientes sin diagnósticos de enfermedad.</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td valign="top">
      <h3>5️⃣ Consultas de Agregación</h3>
      <p>Capacidad de usar <strong>COUNT</strong> y <strong>GROUP BY</strong> sobre las vistas para generar reportes estadísticos rápidos de la clínica.</p>
    </td>
    <td valign="top">
      <h3>6️⃣ Verificación</h3>
      <p>Comprobación de integridad mediante <code>SELECT * FROM vista;</code> asegurando que la data virtual sea consistente con las tablas base.</p>
    </td>
  </tr>
</table>

## 📂 Archivo del Repositorio

El código fuente completo de este laboratorio se encuentra en el repositorio:

> 📄 **[`taller2.3.sql`](./taller2.3.sql)**

---
<p align="center">
  <small>Desarrollado para el Taller de Modelado de Bases de Datos | 2026</small>
</p>

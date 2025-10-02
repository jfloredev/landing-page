import React from 'react';

const Navigation = () => {
  const scrollToSection = (sectionId) => {
    const element = document.getElementById(sectionId);
    if (element) {
      element.scrollIntoView({ 
        behavior: 'smooth',
        block: 'start'
      });
    }
  };

  return (
    <nav className="nav">
      <div className="container">
        <ul>
          <li>
            <a href="#home" onClick={(e) => { e.preventDefault(); scrollToSection('home'); }}>
              Inicio
            </a>
          </li>
          <li>
            <a href="#posts" onClick={(e) => { e.preventDefault(); scrollToSection('posts'); }}>
              Artículos
            </a>
          </li>
          <li>
            <a href="#users" onClick={(e) => { e.preventDefault(); scrollToSection('users'); }}>
              Usuarios
            </a>
          </li>
          <li>
            <a href="#stats" onClick={(e) => { e.preventDefault(); scrollToSection('stats'); }}>
              Estadísticas
            </a>
          </li>
        </ul>
      </div>
    </nav>
  );
};

export default Navigation;

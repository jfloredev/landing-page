import React from 'react';

const Footer = () => {
  const currentYear = new Date().getFullYear();

  return (
    <footer className="footer">
      <div className="container">
        <p>
          © {currentYear} React Landing Page. Desarrollado con React y JSONPlaceholder API.
        </p>
      </div>
    </footer>
  );
};

export default Footer;

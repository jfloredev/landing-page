import React from 'react';

const LoadingSpinner = ({ message = "Cargando..." }) => {
  return (
    <div className="loading">
      <div className="spinner"></div>
      {message}
    </div>
  );
};

export default LoadingSpinner;

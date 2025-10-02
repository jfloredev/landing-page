import React from 'react';
import Header from './components/Header';
import Navigation from './components/Navigation';
import PostsSection from './components/PostsSection';
import UsersSection from './components/UsersSection';
import StatsSection from './components/StatsSection';
import Footer from './components/Footer';

function App() {
  return (
    <div className="App">
      <div id="home">
        <Header />
        <Navigation />
      </div>
      
      <main>
        <PostsSection />
        <UsersSection />
        <StatsSection />
      </main>
      
      <Footer />
    </div>
  );
}

export default App;

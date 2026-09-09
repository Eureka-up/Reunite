import { StrictMode } from 'react';
import { useEffect, useState } from 'react';
import { createRoot } from 'react-dom/client';
import App from './App.tsx';
import { markSessionKnown, me } from './lib/api';
import './index.css';

// eslint-disable-next-line react-refresh/only-export-components
function SessionBootstrap() {
  const [ready, setReady] = useState(false);
  useEffect(() => {
    let active = true;
    const restore = () => {
      void me().then(() => { if (active) markSessionKnown(true); })
        .catch(() => { if (active) markSessionKnown(false); })
        .finally(() => { if (active) setReady(true); });
    };
    const expired = () => {
      markSessionKnown(false);
      setReady(false);
      window.history.pushState({}, "", "/login");
      window.dispatchEvent(new PopStateEvent("popstate"));
      restore();
    };
    window.addEventListener("reunite-session-expired", expired);
    restore();
    return () => { active = false; window.removeEventListener("reunite-session-expired", expired); };
  }, []);
  if (!ready) return <div className="session-splash" aria-hidden="true"><span className="session-splash-mark"><i /><i /></span></div>;
  return <App />;
}

createRoot(document.getElementById('root')!).render(<StrictMode><SessionBootstrap /></StrictMode>);

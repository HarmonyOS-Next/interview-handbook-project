import Theme from "rspress/theme";
import './index.css';

const Layout = () => (
  <Theme.Layout
    afterFeatures={
      <div className="overflow-hidden m-auto flex flex-wrap max-w-6xl" style={{ padding: 30 }}>
        <img src="https://badges.toozhao.com/badges/01HF9APEFVN0K9ZG09DWQS6CJ3/blue.svg" alt="" />
      </div>
    }
  />
);

export default {
  ...Theme,
  Layout,
};

export * from "rspress/theme";

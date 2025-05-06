const { withFederatedSidecar } = require('@module-federation/nextjs-mf');

module.exports = withFederatedSidecar({
  name: 'microfrontend',
  filename: 'static/chunks/remoteEntry.js',
  exposes: {
    './Component': './src/components/Component.tsx',
  },
  remotes: {},
  shared: {
    react: { singleton: true, requiredVersion: false },
    'react-dom': { singleton: true, requiredVersion: false },
  },
})({
  reactStrictMode: true,
  swcMinify: true,
});
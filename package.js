Package.describe({
  name: 'pierreeric:fview-scenarist',
  summary: 'Timelines for animations',
  version: '0.1.0',
  git: 'TODO'
});

Package.onUse(function(api) {
  api.versionsFrom('1.0');
  api.use('mjn:famous@0.3.1_2', 'client', { weak: true });
  api.use('raix:famono@0.9.23', { weak: true });
  api.use([
    'coffeescript@1.0.4',
    'gadicohen:famous-views@0.1.29'
    ], 'client');
  api.addFiles(['FviewScenarist.coffee'], 'client');
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('fview-scenarist');
  api.addFiles('FviewScenaristTests.js');
});
